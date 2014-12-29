# Dubya

A Rack server for your GitHub-hosted Vimwiki. It runs `vim` to recompile
your installed Vimwiki after new changes are pushed to GitHub.

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
