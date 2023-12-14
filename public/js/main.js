
$(document).ready(function(){

    // Submit button on Add-Report

    $('#submit-button').click(function(e){

        e.preventDefault();

        $.ajax({

            url: '/add',

            type: 'post',

            data: $('form').serialize(),

            success: function(){

                $('#modal-message-content').html('A concept has been added.');

                $('#messageModal').modal('show');

                $('form').trigger("reset");

            },

            error: function(err){

                $('#modal-message-content').html('Error occurred: ' + err.message);

                $('#messageModal').modal('show');

            }

        });

    });
 
    // Back button on Add-Report

    $('#back-button').click(function(e){

        e.preventDefault();

        window.location.href = "/";

    });
 
    // Support Materal Modal/Button on Add-Report

    $('#support-material-form').on('submit', function(e){

        e.preventDefault();

        $.ajax({

            url: '/add-support-material',

            type: 'post',

            data: $(this).serialize(),

            success: function(res){

                // Add the new support material to the table

                $('table.table').append('<tr><td>' + res.title + '</td><td>' + res.type + '</td><td>' + res.location + '</td></tr>');

                // Close the modal

                $('#addmaterialformModal').modal('hide');

            },

            error: function(err){

                console.log('Error occurred: ' + err.message);

            }

        });

    });
 
 
    // Toogle Get Concept modal

    $('#advanceSearchModal').on('show.bs.modal', function (e) {

        $('.modal-backdrop').appendTo('#app'); 

    });
 
    // Edit 

    $('.edit-concept').on('click', function(){

        $('#edit-form-title').val($(this).data('title'));

        $('#edit-form-status').val($(this).data('status'));

        $('#edit-form-description').val($(this).data('description'));

        $('#edit-form-inscope').val($(this).data('inscope'));

        $('#edit-form-conceptid').val($(this).data('id'));

        $('#edit-form-name').val($(this).data('name'));

        $('#edit-form-creationdate').val($(this).data('creationdate'));

        $('#edit-form-modificationdate').val($(this).data('modificationdate'));

        $('#edit-form-businessimpactdescription').val($(this).data('businessimpactdescription'));

        $('#edit-form-functionalGroup').val($(this).data('functionalGroup'));

        $('#edit-form-systemFunction').val($(this).data('systemFunction'));

        $('#edit-form-functionname').val($(this).data('functionname'));

        $('#edit-form-subsystemname').val($(this).data('subsystemname'));

        $('#edit-form-modulename').val($(this).data('modulename'));

    });
 
    // Expand all

    $("#expand-all").click(function() {     

        $('.collapse').collapse('show');

    });

    // Collapse all

    $("#collapse-all").click(function() {

        console.log("Collapse button clicked"); 

        $('.collapse').collapse('hide');

    });
 
        // View

        $(".view-concept").on("click", function() {

            var row = $(this).closest("tr");

            var hiddenRow = row.find(".hidden-row");

            var expanded = hiddenRow.data("expanded");

            if (expanded === "false") {

                hiddenRow.data("expanded", "true");

                hiddenRow.addClass("show");

            } else {

                hiddenRow.data("expanded", "false");

                hiddenRow.removeClass("show");

            }

        });


    // Search on enter

    $('.column-search').on('keydown', function(e) {

        if(e.which == 13 ){

            e.preventDefault();

        const titleSearch = $('[data-column="0"]').val();

        const statusSearch = $('[data-column="1"]').val();

        const descSearch = $('[data-column="2"]').val();

        const authorSearch = $('[data-column="3"]').val();
 
        // Now make an AJAX request to your server

        $.get('/', { titleSearch, statusSearch, descSearch, authorSearch }, function(data) {

        // replace the current content with the new results

                $('body').html(data);

            });

        }

    });
 
    // Clear search button

    $('#clearSearchButton').on('click', function() {

        $('[data-column="0"]').val('');

        $('[data-column="1"]').val('');

        $('[data-column="2"]').val('');

        $('[data-column="3"]').val('');

    // Trigger a new search, which will now be empty and show all results

    // (Using the same logic you use on 'keydown' event)

    const titleSearch = $('[data-column="0"]').val();

    const statusSearch = $('[data-column="1"]').val();

    const descSearch = $('[data-column="2"]').val();

    const authorSearch = $('[data-column="3"]').val();

        // Now make an AJAX request to your server

        $.get('/', { titleSearch, statusSearch, descSearch, authorSearch }, function(data) {

            // replace the current content with the new results

            $('body').html(data);

        });

    });
 
    // Toggle employee data

    //$('[data-toggle="tooltip"]').tooltip();
 
    // Delete

    $('.delete-concept').on('click', function(){

        var id = $(this).data('conceptid');

        var url = '/delete/'+id;

        if(confirm('Delete Concept?')){

            $.ajax({

                url: url,

                type:'DELETE',

                success: function(result){

                    console.log('Deleting Concept...');

                    window.location.href='/';

                },

                error: function(err){

                    console.log(err);

                }

            });

        }

    });

});