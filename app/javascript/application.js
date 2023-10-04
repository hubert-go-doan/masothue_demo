// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
window.process = { env: { NODE_ENV: 'production' } };
import * as $ from 'jquery';
import "jquery_ujs"
import '@popperjs/core'
import "bootstrap"
import "@hotwired/turbo-rails"
import "controllers"
import "taxcode"
import "flash"
import "chartkick"
import "Chart.bundle"
import "chart"
// Turbo.session.drive = false  
