const request = require('request');
const moment = require('moment');

const slackChannelUri = 'https://hooks.slack.com/services/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';

const args = process.argv.slice(2);

const filePath = args[0];
const md5 = args[1];
const taskId = args[2];
const dateTime = args[3];

const body = {
  channel     : 'Notifications',
  username    : 'McAfee',
  text        : `*${filePath}*\nmd5: *${md5}*\nATD TaskId: *${taskId}*\n Submitted at ${dateTime}`,
  icon_emoji  : ':exclamation:'
};

console.log('posting', body);

request.post(slackChannelUri, {
  json: body
}, (error, res, body) => {
  if (error) {
    console.error(error);
    return;
  }
  console.log(`statusCode: ${res.statusCode}`);
  console.log(body);
});
