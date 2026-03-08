// Service Workerのインストール時の処理
self.addEventListener('install', function(e) {
    // 待機状態をスキップしてすぐに有効化する
    self.skipWaiting();
  });
  
  // アプリ内の全通信を仲介する処理
  self.addEventListener('fetch', function(e) {
    // キャッシュなし：そのままサーバーにリクエストを投げて返す
    e.respondWith(fetch(e.request));
  });