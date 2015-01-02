# Dubya

A Rack server for your GitHub-hosted Vimwiki. It runs `vim` to recompile
your installed Vimwiki after new changes are pushed to GitHub. This
software powers http://w.psychedeli.ca/.

## Installation

Clone this repo somewhere on your machine.

```bash
$ git clone https://github.com/tubbo/dubya.git
```

Install dependencies and set up your Vimwiki repository.

```bash
$ cd dubya
$ rake setup
```

When your Vimwiki repo is cloned to `src/` (happens automatically when
running the Rake task), you're now ready to start the server!

```bash
$ ./bin/dubya
```

## Usage

Just push your changes to your Vimwiki repo on GitHub, and Dubya will do
all of the work making it available as HTML. Set up an HTTP server like
[Apache][ap] or [Nginx][ng] to serve static files and you'll be all set.
Keep the Rack app running all the time to be able to receive changes
from GitHub. As long as your HTTP server is running, you'll always be
able to access your wiki's contents. To update your repo, just send the
request `POST /wiki` to your Vimwiki installation.

You can also edit your files from the web. Click the big "Edit" button
at the bottom of each page, type in your text, and it will be saved to
Git and subsequently pushed to GitHub. The file will also recompile
itself so you can see changes immediately when the response is done loading.

## Development

All contributions must include tests and be made within a pull request.

### License

Copyright (c) 2014-2015 Tom Scott

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

[ap]: http://httpd.apache.org
[ng]: http://nginx.org
