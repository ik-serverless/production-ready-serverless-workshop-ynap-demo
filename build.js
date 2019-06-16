const fs = require('fs')
const archiver = require('archiver')
const md5File = require('md5-file')
const AWS = require('aws-sdk')
const S3 = new AWS.S3()

const output = fs.createWriteStream(__dirname + '/workshop.zip')
const archive = archiver('zip')

output.on('close', function () {
  console.log('deployment artefact created')

  md5File('workshop.zip', (err, md5) => {
    if (err) {
      throw err
    }

    const filename = `workshop/${md5}.zip`
    console.log(`uploading to S3 as ${filename}`)

    S3.upload({
      Bucket: 'ynap-production-ready-serverless-yancui',
      Key: filename,
      Body: fs.createReadStream(__dirname + '/workshop.zip')
    }, (err, resp) => {
      if (err) {
        throw err
      }

      console.log('artefact has been uploaded to S3')
    })
  })
})

archive.on('error', function(err){
  throw err
})

archive.pipe(output)

archive.directory('functions')
archive.directory('static')
archive.directory('node_modules')

archive.finalize()