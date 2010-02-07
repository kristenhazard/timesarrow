# == Schema Information
# Schema version: 20091217200650
#
# Table name: timelines
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  imageurl    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  category    :string(255)
#  subcategory :string(255)
#  featured    :integer(4)
#  genre       :string(255)
#


class Timeline < ActiveRecord::Base
  
  TIMELINE_CATEGORIES = [
    # Displayed   stored in db
    ["Books",     "Book"],
    ["Music",     "Music"],
    ["Movies",    "Movie"],
    ["Television", "Television"],
    ["Multimedia", "Multimedia"]
  ]
  
  TIMELINE_SUBCATEGORIES = [
    # Displayed   stored in db
    ["Authors",     "Authors"],
    ["Awards",     "Awards"],
    ["Clubs",     "Clubs"],
    ["Reviews",    "Reviews"],
    ["Series",    "Series"],
    ["TOB",    "Tob"]
  ]
  
  TIMELINE_GENRE_BOOKS = [
    # Displayed   stored in db
    ["Adventure",    "Adventure"],
    ["Autobiography",    "Autobiography"],
    ["Beyond Genre",    "Beyond Genre"],
    ["Biography",    "Biography"],
    ["Business",    "Business"],
    ["Children",    "Children"],
    ["Comedy",    "Comedy"],
    ["Cooking",    "Cooking"],
    ["Crime",    "Crime"],
    ["Criticism",    "Criticism"],
    ["Fiction",     "Fiction"],
    ["Graphic Novel",    "Graphic Novel"],
    ["History",    "History"],
    ["Horror",    "Horror"],
    ["Mixed",    "Mixed"],
    ["Mystery",    "Mystery"],
    ["Non Fiction",     "Non Fiction"],
    ["Poetry",    "Poetry"],
    ["Romance",    "Romance"],
    ["Science",    "Science"],
    ["Science Fiction",    "Science Fiction"],
    ["Sports",    "Sports"],
    ["Thriller",    "Thriller"],
    ["Western",    "Western"],
    ["Young People's Lit",    "Young People's Lit"]
  ]
  
  TIMELINE_FEATURED = [
    # Displayed   stored in db
    ["No",     "0"],
    ["Yes",     "1"]
  ]
  
  has_many :items, :through => :timeline_items,  :order => 'title'
  has_many :timeline_items, :order => 'position ASC', :dependent => :destroy do
    # method used to interface with carousel positioning
    # count all finalists in position earlier than current position
    def count_of_finalists(position)
      find(:all, :conditions => ['position < ? and position_type = 2', position ]).size
    end
    # get list of finalists by year
    def finalists_by_year(position_desc)
      find_all_by_position_type_and_position_desc(2,position_desc)
    end
  end
  has_many :winners, :class_name => 'TimelineItem', :conditions => [ 'position_type = 1' ], 
           :order => 'position ASC', :dependent => :destroy
  
  validates_presence_of :name, :category, :subcategory, :genre
  validates_numericality_of :featured, :on => :create, :message => "is not a number"
  validates_inclusion_of :category, :in => TIMELINE_CATEGORIES.map {|disp, value| value}
  validates_inclusion_of :subcategory, :in => TIMELINE_SUBCATEGORIES.map {|disp, value| value}
  validates_inclusion_of :genre, :in => TIMELINE_GENRE_BOOKS.map {|disp, value| value}
  
  named_scope :featured, :include => [ :winners ], 
                         :conditions => { :timelines => {:featured => 1 }}, 
                         :order => 'name'
                         
  named_scope :filtered_cat, lambda { |category| {:conditions => { :category => category.capitalize }, 
                                                  :include => [ :winners ]} }
                                                  
  named_scope :filtered_subcat, lambda { |subcategory| {:conditions => [ "subcategory = ?", subcategory.capitalize ], 
                                                        :include => [ :winners ]} }
                                                        
  named_scope :filtered_genre, lambda { |genre| 
                                        if genre.nil?
                                          { :conditions => {}, 
                                            :include => [ :winners ]} 
                                        else
                                          { :conditions => { :genre => genre.capitalize }, 
                                            :include => [ :winners ]} 
                                        end
                                        }


  def self.search(search, page)
     if search
        search = search.upcase
        paginate :per_page => 5, :page => page,
                 :conditions => ['UPPER(name) like ?', "%#{search}%"],
                 :order => 'name', 
                 :include => [ :winners ]
              
     else
       paginate :per_page => 5, :page => page,
                :order => 'name',
                :include => :winners
     end
  end
                          
  def self.genre_distinct_by_subcat
    find(:all, :group => "genre,subcategory", :select => "genre,subcategory", :order => "subcategory,genre")
  end
                          
end
