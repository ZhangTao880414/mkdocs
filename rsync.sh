#!/bin/bash
cd /mkdocs/book
mkdocs build
rsync -aLuz /mkdocs/book 133.130.113.101:/mkdocs/
