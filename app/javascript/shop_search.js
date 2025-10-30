document.addEventListener("DOMContentLoaded", () => {
    // ページが完全に読み込まれてから実行
    const regionInput = document.getElementById("post_region");
    const shopNameInput = document.getElementById("post_shop_name");
    const button = document.getElementById("search_shop_btn");
    const resultDiv = document.getElementById("shop_result");
    
    if(!button) return; // ボタンが存在しないページでは実行しない

    button.addEventListener("click", async () => {
        const region = regionInput.value.trim(); // 前後の空白を削除
        const shopName = shopNameInput.value.trim();

        // 編集前の店舗情報を非表示に
        const existingShopInfo = document.getElementById('existing_shop_info');
        if (existingShopInfo) {
        existingShopInfo.style.display = 'none';
        }

        //地域も店名も入力されているか
        if (!region || !shopName) {
            resultDiv.innerHTML = `<div class="alert alert-error"><span>都道府県と店舗名の両方を入力してください。</span></div>`;
            return;
        }

        //検索クエリを組み立て
        const query = `${region} ${shopName}`; //例：”京都 スターバックス京都駅店"

        //ローディング表示
        resultDiv.innerHTML = `<div class="flex items-center gap-2"><span class="loading loading-spinner loading-md"></span> 検索中...</div>`;

        try {
            const response = await fetch(`/shops/search_place?query=${encodeURIComponent(query)}`);
            // ↑ GET /shops/search_place?query=京都%20スターバックス京都駅店
            const data = await response.json();
            // ↑ レスポンスをJSONに変換
            // 例: { found: true, places: [{...}, {...}] }

            if (data.error) {
                //APIエラー
                resultDiv.innerHTML = `<div class="alert alert-error"><span>${data.error}</span></div>`;
                return;
            }

            if (data.found && data.places.length > 0) {
                if (data.places.length === 1) {
                    // 1件のみの場合は自動選択
                    displayShopInfo(data.places[0]);
                } else {
                    // 複数の場合は選択させる
                    displayMultipleResults(data.places);
                }
            } else {
                resultDiv.innerHTML = `<div class="alert alert-warning"><span>「${query}」に一致する店舗が見つかりませんでした。このまま投稿できます。</span></div>`;
            }
        } catch (err) {
            console.error (err); // コンソールにエラーを出力（開発者用）
            resultDiv.innerHTML = `<div class="alert alert-error"><span>検索中にエラーが発生しました。</span></div>`;
        }
      });

      // 複数結果を表示
      function displayMultipleResults(places) {
        let html = '<div class="bg-neutral p-4 rounded-lg"><h4 class="text-sm font-bold text-accent mb-3">📍 該当する店舗（クリックして選択）</h4><div class="space-y-2">';

        places.forEach((place) => {
            html += `
            <div class="card bg-primary/20 hover:bg-secondary cursor-pointer transition-all border border-base-content/10" data-place='${JSON.stringify(place)}'>
              <div class="card-body p-3">
                <h5 class="font-bold text-sm">${place.name}</h5>
                <p class="text-xs text-base-content/70">${place.address || '住所情報なし'}</p>
              </div>
            </div>
            `;
        });
        // (let html〜)最後に開いたタグを閉じる
        html += '</div></div>';
        // 作成したHTMLを実際に表示する
        resultDiv.innerHTML = html;

        // 店舗カードをクリックしたら、その店舗の詳細情報を表示する
        resultDiv.querySelectorAll('[data-place]').forEach(card => {
            card.addEventListener(`click`, function(){
                const place = JSON.parse(this.dataset.place);
                displayShopInfo(place);
            });
        });
      }
      // 店舗情報を表示
      function displayShopInfo(place) {
        // 隠しフィールドに保存（フォーム送信時に一緒に送られる）
        document.getElementById(`post-place-id`).value = place.place_id || '';
        document.getElementById(`post-address`).value = place.address || '';
        document.getElementById(`post-map-url`).value = place.google_map_url || '';
        document.getElementById(`post-phone`).value = place.phone_number || '';

        if (place.business_hours && place.business_hours.length > 0) {
            document.getElementById(`post-hours`).value = place.business_hours.join('\n');
            // 配列 → 改行区切りの文字列に変換
        }
        // 表示用HTML
        let html = `
      <div class="bg-accent/10 border border-accent/30 p-4 rounded-lg">
        <h4 class="font-bold mb-3 flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          ${place.name}の店舗情報を取得しました
        </h4>
        <div class="space-y-2 text-sm">
          <p class="flex items-start">
            <span class="font-semibold mr-2">📍</span>
            <span>${place.address || '住所情報なし'}</span>
          </p>
    `;
    // 電話番号
    if (place.phone_number) {
      html += `
        <p class="flex items-start">
          <span class="font-semibold mr-2">📞</span>
          <span>${place.phone_number}</span>
        </p>
      `;
    }
    // 営業時間
    if (place.business_hours && place.business_hours.length > 0) {
      html += `
        <div class="flex items-start">
          <span class="font-semibold mr-2">🕒</span>
          <div class="flex-1">${place.business_hours.map(h => `<div>${h}</div>`).join('')}</div>
        </div>
      `;
    }
    //Googleマップ
    if (place.google_map_url) {
      html += `<a href="${place.google_map_url}" target="_blank" class="btn btn-sm btn-primary text-neutral mt-2">Google Mapsで見る</a>`;
    }

    html += '</div></div>';
    resultDiv.innerHTML = html;

}
});