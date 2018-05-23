# frozen_string_literal: true

Dir['./lib/chess/utils/*.rb'].each { |file| require file }
Dir['./lib/chess/*.rb'].each { |file| require file }
Dir['./lib/chess/pieces/*.rb'].each { |file| require file }
