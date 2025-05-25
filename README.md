
# news_app

A Flutter-based news app that fetches and displays the latest articles using an API. Users can search for news, refresh the feed by pulling, and bookmark articles.

 Setup Instructions
1. Clone the repository:
git clone https://github.com/jhanvi-4103/news_app.git
cd news_app
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run

#Screenshot
1. LoginPage: Screenshot/LoginPage.jpg
2. HomePage: Screenshot/HomePage.jpg
3. Bookmark : Screenshot/Bookmark.jpg
4. article : Screenshot/article.jpg

🧠 Architecture Choices:

The app follows a simplified Provider pattern using:
ChangeNotifier for reactive state management.
Separation of Concerns:
NewsProvider handles state and API calls
NewsService abstracts API logic
UI widgets consume state via Provider.of

📦 Third-Party Packages Used

Package: provider           
Purpose: State management using ChangeNotifier pattern

Package:	http
purpose: Making API requests to fetch news articles

Package: intl

purpose: For formatting dates and times in a readable format.

package: webview_flutter

purpose: To open full articles in an in-app web browser view.

package: shared_preferences

purpose: To store and retrieve simple key-value data like bookmarks locally.

Drive Link with apk:
https://drive.google.com/file/d/1RON6oDFpfyOtQcSp8Ak5N3C-Dk3SkohP/view?usp=drivesdk 
	              

This keeps business logic cleanly separated from UI.
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# news_app
>>>>>>> 00a01fb83a2a1f25ee9a36d75fe918015ab06486
