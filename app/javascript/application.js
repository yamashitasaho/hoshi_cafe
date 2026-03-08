// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./shop_search";
// place API(new)

// Service Workerが使えるブラウザかチェックしてから登録する
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      // ページ読み込み完了後にService Workerを登録する
      navigator.serviceWorker.register('/service_worker.js')
        .then((registration) => {
          console.log('Service Worker registered:', registration);
        })
        .catch((error) => {
          console.error('Service Worker registration failed:', error);
        });
    });
  }