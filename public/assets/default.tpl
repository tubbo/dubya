<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <link type="text/css" rel="stylesheet" href="%root_path%assets/css/normalize.css" />
  <link type="text/css" rel="stylesheet" href="%root_path%assets/css/foundation.min.css" />

  <title>%title% - wiki</title>
</head>
<body>
  <header>
    <nav class="top-bar" data-topbar>
      <ul class="title-area">
        <li class="name">
          <a class="title" href="%root_path%index.html">
            <h1>~tubbo</hh1>
          </a>
        </li>
      </ul>

      <section class="top-bar-section">
        <ul class="right">
          <li><a href="%root_path%WonderBars.html">The Wonder Bars</a></li>
          <li><a href="%root_path%ResearchAndDevelopment.html">Research & Development</a></li>
          <li><a href="%root_path%WaxPoeticRecords.html">Wax Poetic Records</a></li>
        </ul>
      </section>
    </nav>
  </header>

  <section id="content">
    <div class="row">
      <div class="large-12 columns">
        <h1>%title%</h1>
      </div>
    </div>
    <div class="row">
      <div class="large-12 columns">
        %content%
      </div>
    </div>
  </section>

  <footer class="row">
    <div class="large-8 columns">&nbsp;</div>
    <div class="large-4 columns">
      <div class="right" style="text-align:right">
        <a href="#" id="edit-button" class="button" data-reveal-id="dialog">Edit</a>
      </div>
    </div>
    <div id="dialog" class="reveal-modal" data-reveal></div>
  </footer>

  <script type="text/javascript" src="%root_path%assets/js/jquery-2.1.3.js"></script>
  <script type="text/javascript" src="%root_path%assets/js/foundation.min.js"></script>
  <script>$(function() { $(document).foundation(); });</script>
  <script>
    var pageName = (window.location.pathname == '/') ? 'index' : window.location.pathname;
        editURL = '/wiki/'+pageName.split('.html').join('');
    $('#edit-button').attr('href', editURL);
    $('#edit-button').attr('data-reveal-ajax', editURL);
  </script>
</body>
</html>
