const { pool } = require('../utils/database');

exports.getLastQuery = (req, res, next) => {
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];
    
    
    pool.getConnection((err, conn) => {
        var sqlQuery = (`SELECT DISTINCT
        CONCAT(first_name, ' ', last_name) AS full_name,
        COUNT(project_researcher_relationship.project_id) AS projects_number
        FROM researchers
        INNER JOIN project_researcher_relationship ON project_researcher_relationship.researcher_id = researchers.id
        WHERE NOT EXISTS (
            SELECT * FROM deliverable WHERE deliverable.project_id = project_researcher_relationship.project_id
        )
        GROUP BY researchers.id
        HAVING COUNT(project_researcher_relationship.project_id) >= 2
        ORDER BY projects_number DESC`);

        conn.promise().query(sqlQuery)
        .then(([rows, fields]) => {
            res.render('lastquery.ejs', {
                pageTitle: "(Not) Busy Researchers Page",
                researchers: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}