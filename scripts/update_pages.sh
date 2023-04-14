#!/bin/bash

GIT='git --git-dir='$PWD'/.git'

$GIT add index.html
$GIT commit -m "Updated html"
$GIT push
$GIT checkout github_pages
$GIT checkout jonathan_designs -- index.html
$GIT commit -m "Updated html"
$GIT push
$GIT checkout jonathan_designs