let faker = require('faker');
var fs = require('fs');

DUMMY_DATA_NUMBER = 100;
TABLE_NAME = "projects";
TABLE_COLUMNS = ["title", "summary", "amount", "starting_date", "end_date"]
let content = "";

for (i = 0; i < DUMMY_DATA_NUMBER; i++) {
    title = faker.random.word();
    summary = faker.random.words(10);
    amount = faker.datatype.number();
    startDate = faker.date.recent();
    endDate = faker.date.future();
    content += "INSERT INTO " + TABLE_NAME + " (" + TABLE_COLUMNS.join(",") + ') VALUES ("' +
    title + '","' + summary + '","' + amount + '","' + startDate + '","' + endDate + '");\n';
}

fs.writeFile('dummy_data_' + TABLE_NAME + '.txt', content, (err) => {
  if (err) throw err;
  console.log('File is created successfully.');
});
