<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
  <meta charset="UTF-8">
  <title>HELLO-MAN SYSTEM AUDITOR - README</title>
  <style>
    body {
      font-family: Tahoma, Arial, sans-serif;
      text-align: right;
      direction: rtl;
      margin: 20px;
      line-height: 1.6;
    }
    pre {
      background: #f4f4f4;
      padding: 10px;
      border: 1px solid #ccc;
      white-space: pre-wrap;
    }
    h1, h2, h3 {
      margin-top: 20px;
    }
    ul, ol {
      margin-right: 20px;
    }
    hr {
      margin: 20px 0;
    }
  </style>
</head>
<body>

<h1>HELLO-MAN SYSTEM AUDITOR</h1>
<hr>

<h2>معرفی</h2>
<p>
HELLO-MAN SYSTEM AUDITOR یک اسکریپت Bash قدرتمند و جامع برای جمع‌آوری اطلاعات سیستم و تهیه گزارشی کامل از وضعیت سیستم شماست.
این اسکریپت با استفاده از ابزارهای سیستم، اطلاعات مربوط به سیستم عامل، کرنل، نرم‌افزارهای نصب شده، سرویس‌های فعال (و در صورت نیاز سرویس‌های متوقف شده)، وضعیت شبکه، فضای ذخیره‌سازی، وضعیت فایروال و خلاصه‌ای از وضعیت کلی سیستم (مانند زمان کارکرد، میانگین بار و مصرف حافظه) را استخراج کرده و در یک فایل متنی ذخیره می‌کند.
</p>

<h2>ویژگی‌ها</h2>
<ul>
  <li><strong>نمایش انیمیشن شروع:</strong> نمایش یک انیمیشن رنگی جهت جذاب‌سازی روند راه‌اندازی.</li>
  <li><strong>اسکن شبکه:</strong> در صورت نصب بودن <code>nmap</code> از آن برای اسکن سریع پورت‌ها استفاده شده و در غیر این صورت از پینگ برای شناسایی میزبان‌های فعال بهره می‌برد.</li>
  <li><strong>بررسی سرویس‌ها:</strong> نمایش سرویس‌های در حال اجرا و (در صورت انتخاب) سرویس‌های متوقف شده.</li>
  <li><strong>جمع‌آوری اطلاعات سیستم:</strong> شامل اطلاعات سیستم عامل، کرنل و نرم‌افزارهای نصب شده (بر اساس مدیر بسته apt یا rpm) می‌باشد.</li>
  <li><strong>نمایش وضعیت شبکه، فضای ذخیره‌سازی و فایروال:</strong> ارائه اطلاعاتی مانند آدرس‌های IP، نتایج اسکن شبکه، وضعیت فضای دیسک و وضعیت فایروال (با استفاده از ufw، firewall-cmd یا iptables).</li>
  <li><strong>خلاصه وضعیت سیستم:</strong> شامل زمان کارکرد، میانگین بار و مصرف حافظه.</li>
  <li><strong>ذخیره گزارش:</strong> تولید فایل گزارشی با نام استاندارد به صورت <code>HELLO_YYYYMMDD_HHMM.txt</code> در مسیر اجرای اسکریپت.</li>
</ul>

<h2>پیش‌نیازها</h2>
<ul>
  <li>سیستم‌عامل‌های مبتنی بر لینوکس</li>
  <li>شل Bash</li>
  <li>ابزارهای مورد استفاده:
    <ul>
      <li><code>ip</code> و <code>awk</code></li>
      <li><code>systemctl</code></li>
      <li><code>df</code>، <code>uptime</code>، <code>free</code></li>
      <li><code>nmap</code> (اختیاری؛ جهت اسکن شبکه در صورت نصب)</li>
      <li><code>ufw</code> یا <code>firewall-cmd</code> یا <code>iptables</code> (برای بررسی وضعیت فایروال)</li>
    </ul>
  </li>
  <li>دسترسی کافی (ممکن است برای برخی اطلاعات نیاز به دسترسی ریشه باشد)</li>
</ul>

<h2>نحوه استفاده</h2>
<ol>
  <li>
    <strong>دانلود یا کپی اسکریپت:</strong>
    <p>فایل اسکریپت (مثلاً <code>hello-man.sh</code>) را در سیستم خود ذخیره کنید.</p>
  </li>
  <li>
    <strong>دادن مجوز اجرا:</strong>
    <p>در صورتی که اسکریپت قابلیت اجرا ندارد، دستور زیر را در ترمینال وارد کنید:</p>
    <pre>chmod +x hello-man.sh</pre>
  </li>
  <li>
    <strong>اجرای اسکریپت:</strong>
    <p>در ترمینال دستور زیر را اجرا کنید:</p>
    <pre>./hello-man.sh</pre>
  </li>
  <li>
    <strong>تعامل با اسکریپت:</strong>
    <ul>
      <li>در هنگام اجرا، اسکریپت از شما می‌پرسد آیا می‌خواهید اسکن شبکه انجام شود یا خیر. پاسخ دهید با <code>y</code> (برای بله) یا <code>n</code> (برای خیر).</li>
      <li>در پرسش دوم، در صورت تمایل به نمایش سرویس‌های متوقف شده نیز پاسخ <code>y</code> یا <code>n</code> را وارد کنید.</li>
    </ul>
  </li>
  <li>
    <strong>مشاهده گزارش:</strong>
    <p>پس از پایان اجرا، یک فایل متنی با نام مشابه <code>HELLO_YYYYMMDD_HHMM.txt</code> ایجاد می‌شود که شامل گزارش جامع وضعیت سیستم شماست.</p>
  </li>
</ol>

<h2>جزئیات بخش‌های گزارش</h2>
<ul>
  <li><strong>[SYSTEM]:</strong> اطلاعات سیستم عامل (OS) و کرنل سیستم.</li>
  <li><strong>[SOFTWARE]:</strong> لیستی از نرم‌افزارهای نصب شده (با توجه به مدیر بسته apt یا rpm).</li>
  <li><strong>[SERVICES]:</strong> نمایش سرویس‌های در حال اجرا و (در صورت انتخاب) سرویس‌های متوقف شده.</li>
  <li><strong>[NETWORK]:</strong> نمایش آدرس‌های IP سیستم و، در صورت فعال بودن گزینه، نتایج اسکن شبکه.</li>
  <li><strong>[STORAGE]:</strong> نمایش وضعیت فضای دیسک (به جز tmpfs و loop).</li>
  <li><strong>[FIREWALL STATUS]:</strong> بررسی وضعیت فایروال (با استفاده از ufw، firewall-cmd یا iptables).</li>
  <li><strong>[SUMMARY]:</strong> خلاصه‌ای از وضعیت سیستم شامل زمان کارکرد (uptime)، میانگین بار و مصرف حافظه.</li>
  <li><strong>[END]:</strong> زمان دقیق تولید گزارش.</li>
</ul>

<h2>سازنده و وب‌سایت</h2>
<ul>
  <li><strong>نام سازنده:</strong> Shayan Taki</li>
  <li><strong>وب‌سایت:</strong> <a href="https://shirdalcode.ir" target="_blank">shirdalcode.ir</a></li>
</ul>

<h2>نکات مهم</h2>
<ul>
  <li>در صورت عدم نصب <code>nmap</code>، اسکریپت از پینگ برای اسکن شبکه استفاده می‌کند.</li>
  <li>برخی از دستورات ممکن است نیاز به دسترسی سطح بالا (مثل root) داشته باشند.</li>
  <li>این اسکریپت به صورت رایگان ارائه شده است؛ لذا در صورت استفاده، ذکر نام سازنده و وب‌سایت <code>shirdalcode.ir</code> مورد تشکر قرار می‌گیرد.</li>
</ul>

<h2>مجوز</h2>
<p>
این اسکریپت به صورت آزاد و رایگان ارائه شده و می‌توانید آن را به دلخواه تغییر داده و توزیع کنید. در استفاده، لطفاً به نام سازنده (<strong>Shayan Taki</strong>) و وب‌سایت <a href="https://shirdalcode.ir" target="_blank">shirdalcode.ir</a> اشاره نمایید.
</p>

<hr>
</body>
</html>
