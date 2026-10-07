# MeydanGSM Yönetim — kurulum

Klasörde dört dosya var: `index.html` (site), `config.js` (bağlantı ayarı), `schema.sql` (veritabanı), bu not.
Supabase ve Vercel ekranlarındaki menü adları zamanla biraz değişebilir.

## 1. Veritabanı (Supabase)
1. supabase.com'da ücretsiz hesap açın, yeni bir proje oluşturun (bölge: Frankfurt yakın olur).
2. `schema.sql` dosyasını açın, en alttaki `SIZIN-EPOSTANIZ@ornek.com` yerine panele gireceğiniz e-postayı yazın.
3. Supabase'de **SQL Editor**'e dosyanın tamamını yapıştırıp **Run** deyin.
4. **Authentication > Users > Add user** ile aynı e-postayla bir kullanıcı oluşturun, şifresini belirleyin ("Auto Confirm User" işaretli olsun).
5. **Authentication > Sign In / Providers** altında **"Allow new users to sign up"** seçeneğini KAPATIN. (Açık kalsa da yetkili listesinde olmayan kimse veriyi göremez; kapatmak ikinci kilittir.)

## 2. Bağlantı ayarı
1. Supabase'de **Project Settings > API** sayfasından **Project URL** ve **anon public** anahtarını kopyalayın.
2. `config.js` içindeki iki değerin yerine yapıştırın. `service_role` anahtarını hiçbir yere yazmayın.

## 3. Yayınlama
En kolayı: app.netlify.com/drop adresine `meydangsm-panel` klasörünü sürükleyip bırakmak.
Vercel isterseniz: klasörü bir GitHub deposuna koyun, vercel.com'da **Add New > Project** ile depoyu seçin; derleme ayarı gerekmez (statik site).
İkisi de ücretsiz bir adres verir (ör. `meydangsm-panel.vercel.app`).

## 4. panel.meydangsm.com (isteğe bağlı)
Yayınladığınız serviste **Domains** bölümüne `panel.meydangsm.com` ekleyin. Servis size bir CNAME değeri gösterir; alan adınızın DNS yönetiminde `panel` adına o değeri CNAME olarak girin.

## Başka birine yetki vermek
SQL Editor'de: `insert into public.yetkili (email) values ('kisi@ornek.com');` ve Authentication > Users'tan o kişiye kullanıcı açın.

## Yedek
Supabase'de **Table Editor > kayitlar > Export** ile tüm kayıtları CSV olarak indirebilirsiniz. Ücretsiz projeler uzun süre kullanılmazsa Supabase tarafından duraklatılabilir; panelden yeniden başlatılır.
