require 'json'

class Book
    attr_accessor :title, :author, :isbn

    def initialize(title, author, isbn)
        @title = title
        @author = author
        @isbn = isbn
    end
end

class Inventory
    attr_accessor :books

    def initialize
        @books =[]
    end#initialize

    def add_book()
        print "Enter title: "
        title = gets.chomp
        print "Enter author: "
        author = gets.chomp
        print "Enter ISBN: "
        isbn = gets.chomp

        books_data = []
        if File.exist?('books.json')
            begin
                books_data = JSON.parse(File.read('books.json'))
            rescue JSON::ParserError
                books_data = []
            end
        end

        existing_entry = books_data.find { |entry| entry['isbn'] == isbn }
        if existing_entry
            existing_entry['count'] += 1
        else
            book = Book.new(title, author, isbn)
            books_data << { 'isbn' => book.isbn, 'title' => book.title, 'author' => book.author, 'count' => 1 }
        end

        File.write('books.json', JSON.pretty_generate(books_data))
    end#add_book

    def remove_book()
        print "Enter ISBN: "
        isbn = gets.chomp

        books_data = []
        if File.exist?('books.json')
            begin
                books_data = JSON.parse(File.read('books.json'))
            rescue JSON::ParserError
                books_data = []
            end
        end

        books_data.reject! { |entry| entry['isbn'] == isbn }

        File.write('books.json', JSON.pretty_generate(books_data))
    end#remove_book

    def list_books
        books_data = []
        if File.exist?('books.json')
            begin
                books_data = JSON.parse(File.read('books.json'))
            rescue JSON::ParserError
                books_data = []
            end
        end

        books_data.each do |entry|
            puts "ISBN: #{entry['isbn']}, Title: #{entry['title']}, Author: #{entry['author']}, Count: #{entry['count']}"
        end
    end#list_books

end#class Inventory

class Menu
    attr_reader :inv
    def initialize(inv)
        @inv = inv
        # render
    end
    #initialize

    def render
        puts ""
        puts "1. Add a book."
        puts "2. Remove a book."
        puts "3. List books."
        puts "choose:"
        cmd = gets.chomp

        case cmd
        when "1"
            inv.add_book
        when "2"
            inv.remove_book()
        when "3"
            inv.list_books
        else
            puts "Invalid command"
        end
    end#render
end#Menu

class Main
    def self.main
        inventory = Inventory.new
        menu = Menu.new(inventory)
        while true
            menu.render
        end#while
    end#main
end#Main

Main.main()