require 'pagy/extras/bootstrap'
require 'pagy/extras/array'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 25
Pagy::DEFAULT[:size]  = [1, 3, 3, 1]
Pagy::DEFAULT[:overflow] = :last_page
