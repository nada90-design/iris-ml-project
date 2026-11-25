# Iris ML Project

A machine learning model that classifies iris flowers, served through a Flask API and connected to a Flutter mobile app.

## What is in this repo
- Iris classification project.ipynb: training code for the model
- iris_model.joblib: the trained model, saved with joblib
- app.py: Flask API that loads the model and returns predictions
- test_post.py: script to test the API with a sample request
- lib/ and pubspec.yaml: the Flutter app that sends data to the API and shows the result

## How to run
1. Run the API: install Flask, scikit-learn and joblib, then run `flask --app app run`
2. Test it: `python test_post.py`
3. Run the app: `flutter pub get`, then `flutter run`

## Data
The model is trained on the Iris dataset.
--------------------------------------------------------------------------------------------------------------------------------
# مشروع تصنيف زهور الآيرس بالـ Machine Learning

موديل Machine Learning بيصنّف نوع زهرة الآيرس، متوصل بـ Flask API وبتطبيق موبايل Flutter يعرض النتيجة.

## محتويات المشروع
- Iris classification project.ipynb: كود تدريب الموديل
- iris_model.joblib: الموديل المدرّب ومحفوظ بـ joblib
- app.py: الـ Flask API اللي بيحمّل الموديل ويرجّع التوقع
- test_post.py: سكربت لتجربة الـ API بطلب تجريبي
- lib/ وpubspec.yaml: تطبيق Flutter اللي بيبعت البيانات للـ API ويعرض النتيجة

## طريقة التشغيل
1. شغّلي الـ API: نزّلي Flask وscikit-learn وjoblib، وبعدين نفّذي `flask --app app run`
2. جرّبيه: `python test_post.py`
3. شغّلي التطبيق: `flutter pub get` وبعدها `flutter run`

## البيانات
الموديل متدرّب على داتا الآيرس (Iris dataset).
