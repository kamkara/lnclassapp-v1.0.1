<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '<%= Rails.application.credentials.dig(:google_analytics) %>');
</script>
