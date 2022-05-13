const { pool } = require('../utils/database');

/* Controller to retrieve grades from database */
exports.getProjects = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query('SELECT * FROM projects')
        .then(([rows, fields]) => {
            res.render('projects.ejs', {
                pageTitle: "Projects Page",
                projects: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}

/* Controller to delete grade by ID from database */
exports.postDeleteProject = (req, res, next) => {
    /* get id from params */
    const id = req.params.id;
    
    /* create the connection, execute query, flash respective message and redirect to grades route */
    pool.getConnection((err, conn) => {
        var sqlQuery = 'DELETE FROM projects WHERE id = ${id}';

        conn.promise().query(sqlQuery)
        .then(() => {
            pool.releaseConnection(conn);
            req.flash('messages', { type: 'success', value: "Successfully deleted project!" })
            res.redirect('/projects');
        })
        .catch(err => {
            req.flash('messages', { type: 'error', value: "Something went wrong, Project could not be deleted." })
            res.redirect('/projects');
        })
    })

}