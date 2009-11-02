#create_table "timelines", :force => true do |t|
#  t.string   "name"
#  t.string   "description"
#  t.string   "imageurl"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.string   "category"
#  t.string   "subcategory"
#  t.integer  "featured"
#  t.string   "genre"
#end

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
    ["Awards",     "Awards"],
    ["Clubs",     "Clubs"],
    ["Reviews",    "Reviews"],
    ["Series",    "Series"]
  ]
  
  TIMELINE_GENRE_BOOKS = [
    # Displayed   stored in db
    ["Adventure",    "Adventure"],
    ["Autobiography",    "Autobiography"],
    ["Beyond Genre",    "Beyond Genre"],
    ["Biography",    "Biography"],
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
    ["Yes",     "1"],
    ["No",     "0"]
  ]
  
  has_many :items, :through => :timeline_items,  :order => 'title'
  has_many :timeline_items, :order => 'position ASC', :dependent => :destroy do
    # method used to interface with carousel positioning
    # count all finalists in position earlier than current position
    def count_of_finalists(position)
      find(:all, :conditions => ['position < ? and position_type = 2', position ]).count
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
  
  named_scope :featured, :include => [ :items, :timeline_items ], 
                         :conditions => { :timelines => {:featured => 1 }}, 
                         :order => 'subcategory, genre'
                         
  named_scope :filtered_cat, lambda { |category| {:conditions => { :category => category }, 
                                                  :include => [ :items, :timeline_items ]} }
                                                  
  named_scope :filtered_subcat, lambda { |subcategory| {:conditions => [ "subcategory = ?", subcategory ], 
                                                        :include => [ :items, :timeline_items ]} }
                                                        
  named_scope :filtered_genre, lambda { |genre| 
                                        if genre.nil?
                                          { :conditions => {}, 
                                            :include => [ :items, :timeline_items ]} 
                                        else
                                          { :conditions => { :genre => genre }, 
                                            :include => [ :items, :timeline_items ]} 
                                        end
                                        }


                          
  
                          
end
