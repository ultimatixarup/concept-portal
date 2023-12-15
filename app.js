
// web app variables
const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const cons = require('consolidate');
const dust = require('dustjs-helpers');
const app = express();

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'password',
    port: 5432,
  })
 
// Register custom Dust filter
dust.filters.formatDate = function (value) {
    const modificationDate = new Date(value);
    return modificationDate.toLocaleDateString('en-US', {
        month: '2-digit',
        day: '2-digit',
        year: 'numeric'
    });
}
 
// DB connect string
var connect = "postgres://localhost:5432/postgres";
 
// Assign Dust Engine To .dust Files
app.engine('dust', cons.dust);
 
// Set Default Ext .dust
app.set('view engine', 'dust');
app.set('views', __dirname + '/views');
 
// Set public Folder
app.use(express.static(path.join(__dirname, 'public')));
 
// Body Parser Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
 
 
// Establishes connection on db on postgres
// const pool = new Pool({ connectionString: connect });
 
// Gets data from tables
app.get('/table', async (req, res) => {
    console.log("in table-l52");
    try {      
        const client = await pool.connect();
        let conceptQuery = `
            select c.*, bi.*, acl.*, e.name, e.employeeid, csl.*, s.*
            FROM mydb.concept as c
            LEFT JOIN mydb.BusinessImpact as bi ON c.conceptid = bi.conceptid
            LEFT JOIN mydb.AuthorConceptLkup as acl ON c.ConceptId = acl.ConceptId
            LEFT JOIN mydb.Employee as e ON acl.employeeid = e.employeeId
            LEFT JOIN mydb.ConceptSubsystemLkup as csl ON c.conceptid = csl.conceptid
            LEFT JOIN mydb.Subsystem as s ON csl.subsystemid = s.subsystemid
            WHERE true
        `;
        let searchParams = [];
        
        let searchConditions = [];
        const { titleSearch, statusSearch, descSearch, authorSearch } = req.query;

        console.log("table.dust---"+searchParams);
        if (titleSearch) {
            searchConditions.push("LOWER(c.title) LIKE LOWER($" + (searchParams.length + 1) + ")" );
            searchParams.push(`%${titleSearch}%`);
        }
        if  (statusSearch) {
            searchConditions.push("LOWER(c.status) LIKE LOWER($" + (searchParams.length + 1) + ")" );
            searchParams.push(`%${statusSearch}%`);
        }
        if (descSearch) {
            searchConditions.push("LOWER(c.description) LIKE LOWER($" + (searchParams.length + 1) + ")" );
            searchParams.push(`%${descSearch}%`);
        }
        if (authorSearch) {
            searchConditions.push("LOWER(e.name) LIKE LOWER($" + (searchParams.length + 1) + ")" );
            searchParams.push(`%${authorSearch}%`);
        }
        if (searchConditions.length > 0) {
            conceptQuery += " AND (" + searchConditions.join(" AND ") + ")";
        }
        console.log("table.dust---"+searchParams);
        //const conceptResult = await client.query(conceptQuery)
        console.log("in table-l52=="+conceptQuery);
        const conceptResult = await client.query(conceptQuery, searchParams);
        //const conceptSearchResult = await client.query(conceptSearchQuery, searchParams);
        console.log("in table : l91="+conceptResult);
        const concepts = conceptResult.rows;
 
 
        // Loop over each concept and fetch the TRL advancements, support materials, and patents
        for (const concept of concepts) {
        // Format modification dates as MM-DD-YEAR
        if(concept.modificationDate) {
            const modifcationDate = new Date(concept.modificationdate);
            const formattedModificationDate = modifcationDate.toLocaleDateString('en-US', {
                month: '2-digit',
                day: '2-digit',
                year: 'numeric'
            });                 
            concept.modificationdate = formattedModificationDate;
        } else {
            concept.modificationDate = null;
        }
        if(concept.creationDate) {
            const creationDate = new Date(concept.creationdate);
            const formattedCreationDate = creationDate.toLocaleDateString('en-US', {
                month: '2-digit',
                day: '2-digit',
                year: 'numeric'
            }); 
            concept.creationdate = formattedCreationDate;
        } else {
            concept.creationDate = null;
        }
            let trlQuery = 'SELECT * FROM mydb.ConceptTrlLkup as ctl JOIN mydb.TrlAdvancement as trl ON ctl.trlid = trl.trlid WHERE ctl.conceptid = $1';
            let trlResult = await client.query(trlQuery, [concept.conceptid]);
            concept.trl = trlResult.rows;
            let materialQuery = 'SELECT * FROM mydb.ConceptMaterialLkup as cml JOIN mydb.SupportMaterial as sm ON cml.materialid = sm.supportmaterialId WHERE cml.ConceptId = $1';
            let materialResult = await client.query(materialQuery, [concept.conceptid]);
            concept.supportmaterial = materialResult.rows;
            let patentQuery = 'SELECT * FROM mydb.PatentConceptLkup as pcl JOIN mydb.Patent as p ON pcl.patentid = p.patentId WHERE pcl.ConceptId = $1';
            let patentResult = await client.query(patentQuery, [concept.conceptid]);
            concept.patent = patentResult.rows;
            let functionQuery = `
                SELECT * FROM mydb.SubsystemFunctionLkup as sfl 
                JOIN mydb.Function as f ON sfl.functionid = f.functionId 
                JOIN mydb.ConceptSubsystemLkup as csl ON csl.subsystemid = sfl.subsystemid
                WHERE csl.conceptId = $1`;
            //concept.function = functionResult.rows.map(r=>r.functionname).join(", ");
 
            let functionResult = await client.query(functionQuery, [concept.conceptid]);
            let functionNames = new Set(functionResult.rows.map(r => r.functionname));
            let systemFunctions = new Set(functionResult.rows.map(r => r.systemfunction));
            let functionalGroups = new Set(functionResult.rows.map(r => r.functionalgroup));
 
            concept.function = Array.from(functionNames).join(", ");
            concept.systemFunction = Array.from(systemFunctions).join(", ");
            concept.functionalGroup = Array.from(functionalGroups).join(", ");
 
            let moduleQuery = `
                SELECT modulename FROM mydb.SubsystemModuleLkup as sml 
                JOIN mydb.Module as m ON sml.moduleid = m.moduleId
                JOIN mydb.ConceptSubsystemLkup as csl ON csl.subsystemid = sml.subsystemid
                WHERE csl.conceptId = $1`;
            let moduleResult = await client.query(moduleQuery, [concept.conceptid]);
            concept.module = moduleResult.rows.map(r=>r.modulename).join(", ");
            //console.log("Module Data: ", concept.module);
        };
        /// data pull test
        console.log("Concept Data:", concepts);
        res.render('table', { 
            concept: concepts,
            titleSearch,
            statusSearch,
            descSearch,
            authorSearch
            });
        client.release();
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).send('Internal Server Error');
    }
});
 
 
 
// Adds Concepts
app.post('/add', async(req, res) => {
    let client;
    console.log("inside add method");
    try {
        client = await pool.connect();
        const sanitizedValue = (value) => value === "" ? null : value;
        const {
            title, status = null, description = null, inscope = null, creationdate = null,
            name = null, initial = null,
            businessimpactdescription = null,
            subsystemname = null
        } = req.body;
        const safeStatus = sanitizedValue(status);
        const safeDescription = sanitizedValue(description);
        const safeInscope = sanitizedValue(inscope);
        const safeCreationDate = sanitizedValue(creationdate);
        const safeName = sanitizedValue(name);
        const safeInitial = sanitizedValue(initial);
        const safeBusinessImpactDescription = sanitizedValue(businessimpactdescription);
        const safeSubsystemname = sanitizedValue(subsystemname);
 
        // Checks for important empty boxes
        if (!title || title == "" ) {
            res.status(400).send('Title is required');
            return;
        }
 
        // Insert into Concept table
        const conceptQuery = `
            INSERT INTO mydb.Concept(Title, Status, Description, InScope, Creationdate)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING conceptid
        `;

        console.log("concept query="+conceptQuery);
        const conceptValues = [title, status, description, inscope, creationdate];
        console.log("concpet values:"+conceptValues);
        const conceptResult = await client.query(conceptQuery, conceptValues);
        const conceptid = conceptResult.rows[0].conceptid;

        console.log("concept id="+conceptid)
        // test
        //console.log(conceptQuery, conceptResult);
        //console.log(conceptResult);
 
        // Insert into Employee table
        const checkEmployeeQuery = `
             SELECT EmployeeID FROM mydb.Employee WHERE Name = $1 AND Initial = $2
        `;
         const checkEmployeeValues = [name, initial];
         const existingEmployee = await client.query(checkEmployeeQuery, checkEmployeeValues);
         let employeeid;
         if (existingEmployee.rows.length > 0){
             // Employee already exist, grab ID
             employeeid = existingEmployee.rows[0].employeeid;
         } else {
             // Insert into employee table
             const employeeQuery = `
                INSERT INTO mydb.Employee(name, initial)
                VALUES ($1, $2)
                RETURNING employeeid
            `;
             const employeeValues = [name, initial];
             const employeeResult = await client.query(employeeQuery, employeeValues);
             employeeid = employeeResult.rows[0].employeeid;
         }
         // Insert into Author Concept table
         const authorConceptQuery = `
             INSERT INTO mydb.AuthorConceptLkup(employeeID, conceptID)
             VALUES ($1, $2)
         `;
         const authorConceptValues = [employeeid, conceptid];
         await client.query(authorConceptQuery, authorConceptValues);
 
 
         if(safeBusinessImpactDescription){
         // Insert into business impact table
         const businessImpactQuery = `                                                                                                                                                         
             INSERT INTO mydb.businessimpact(conceptid, businessimpactdescription)
             VALUES ($1, $2)
             `;
         const businessImpactValues = [conceptid, businessimpactdescription];
         await client.query(businessImpactQuery, businessImpactValues);
         }
 
 
         if (safeSubsystemname) {
         // Insert into subsystem table
         const subsystemQuery = `
         INSERT INTO mydb.subsystem(subsystemname)
         VALUES ($1)
         RETURNING subsystemid
         `;
         const subsystemValues = [subsystemname];
         const subsystemResult = await client.query(subsystemQuery, subsystemValues);
         const subsystemid = subsystemResult.rows[0].subsystemid;
         // Insert into subsystem concept table
         const conceptsubsystemlkupQuery = `
             INSERT INTO mydb.conceptsubsystemlkup(subsystemid, conceptid)
             VALUES ($1, $2)
             `;
         const conceptsubsystemlkupValues = [subsystemid, conceptid];
         await client.query(conceptsubsystemlkupQuery, conceptsubsystemlkupValues);
        }

        
        await client.query('COMMIT');
        res.render('table');
    } catch (err) {
        console.error('Error executing query', err.stack);
        //res.status(500).send('Internal Server Error');
        res.status(500).json({ error: err.message });
        if (client) {
            await client.query('ROLLBACK');
        }
    } finally {
        if (client) {
            client.release();
        }
    }
});
 
// // Adds Support Materials to table on Add-Report page
// app.post('/add-support-material', async(req, res) => {
//     let client;
//     try {
//         client = await pool.connect();
//         const { supportmaterialtitle, type, location } = req.body;
 
//         // Insert into SupportMaterial table
//         const materialQuery = `
//             INSERT INTO mydb.SupportMaterial(supportmaterialtitle, type, location)
//             VALUES ($1, $2, $3)
//             RETURNING supportmaterialId
//         `;
//         const materialValues = [supportmaterialtitle, type, location];
//         const materialResult = await client.query(materialQuery, materialValues);
//         const materialId = materialResult.rows[0].supportmaterialId;
 
//         // Commit the transaction
//         await client.query('COMMIT');
//         res.status(200).json({ title: supportmaterialtitle, type, location });
//     } catch (err) {
//         if (client) {
//             await client.query('ROLLBACK');
//         }
//         console.error('Error executing query', err.stack);
//         res.status(500).json({ error: err.message });
//     } finally {
//         if (client) {
//             client.release();
//         }
//     }
// });
 
 
// Delete Concepts
app.delete('/delete/:id', async(req, res) => {
    const conceptId = req.params.id;
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        const tables = [
            'ConceptTrlLkup',
            'ConceptMaterialLkup',
            'PatentConceptLkup',
            'ConceptSubsystemLkup',
            'AuthorConceptLkup'
        ];
        for(let i = 0; i < tables.length; i++) {
            await client.query(`DELETE FROM mydb.${tables[i]} WHERE conceptid = $1`, [conceptId]);
        }
 
        // finally, delete the concept
        await client.query('DELETE FROM mydb.concept WHERE conceptid = $1', [conceptId]);
 
        await client.query('COMMIT');
    } catch (err) {
        await client.query('ROLLBACK');
        console.error('Error executing query', err);
        res.status(500).send('Internal Server Error');
    } finally {
        await client.release();
    }
});
 
 
// Edit Concepts
app.post('/edit', async(req, res) => {
    try {
        const client = await pool.connect();
        const result = await client.query("UPDATE mydb.concept SET title=$1, status=$2, description=$3, inscope=$4 WHERE conceptid=$5",
        [req.body.title, req.body.status, req.body.description, req.body.inscope, req.body.conceptid]);
        client.release();
        res.redirect('/');
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).send('Internal Server Error');
    }
});
 
// takes user to add concept page
app.get('/addreport', (req, res) => {
    res.render('addreport');
});

app.get('/', (req, res) => {
    res.render('sign-in');
});

app.get('/sign-in', (req, res) => {
    res.render('sign-in');
});

app.get('/dashboard', (req, res) => {
    console.log("in dashboard.........");
    res.render('dashboard');
});
 
// takes user to add concept page

 
// Server
app.listen(3000, function() {
    console.log('Server Started On Port 3000');
});
 
