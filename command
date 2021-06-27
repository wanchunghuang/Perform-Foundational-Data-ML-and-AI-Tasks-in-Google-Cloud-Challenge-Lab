#1 Use Google Cloud Speech API to analyze the audio file


export API_KEY=<YOUR-API-KEY>

######
{
  "config": {
      "encoding":"FLAC",
      "languageCode": "en-US"
  },
  "audio": {
      "uri":"gs://cloud-training/gsp323/task4.flac"
  }
}
######

curl -s -X POST -H "Content-Type: application/json" --data-binary @gsc-request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > task4-gcs.result

gsutil cp task4-gcs.result gs://<YOUR-PROJECT_ID>-marking/task4-gcs.result

=====
#2 Use the Cloud Natural Language API to analyze the sentence from text


gcloud ml language analyze-entities --content="Old Norse texts portray Odin as one-eyed and long-bearded, frequently wielding a spear named Gungnir and wearing a cloak and a broad hat." > task4-cnl.result


gsutil cp task4-cnl.result gs://<YOUR-PROJECT_ID>-marking/task4-cnl.result

=====
#3 Use Google Video Intelligence and detect all text on the video


#####
{
   "inputUri":"gs://spls/gsp154/video/train.mp4",
   "features": [
       "LABEL_DETECTION"
   ]
}
#####

gcloud auth activate-service-account --key-file key.json
export TOKEN=$(gcloud auth print-access-token)


curl -s -H 'Content-Type: application/json' \
   -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
   'https://videointelligence.googleapis.com/v1/videos:annotate' \
   -d @gvi-request.json > task4-gvi.result
   
   gsutil cp task4-gvi.result gs://<YOUR-PROJECT_ID>-marking/task4-gvi.result
