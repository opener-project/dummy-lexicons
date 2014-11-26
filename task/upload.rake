desc 'Uploads the lexicons to S3'
task :upload do
  archive = 'dummy-hotel-lexicons.tar.gz'

  sh "tar -cvf #{archive} hotel"
  sh "aws s3 cp --acl public-read #{archive} s3://opener"
  sh "rm #{archive}"
end
