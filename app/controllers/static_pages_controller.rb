class StaticPagesController < ApplicationController
  def index
    @signup_request = SignupRequest.new
    @notifications = params[:load] == 'load'
  end
  
  def about
    @signup_request = SignupRequest.new
  end
  
  def contact
    @signup_request = SignupRequest.new
  end
  
  def submit_contact
    UserMailer.new_contact_form_entry(params[:name],params[:email],params[:subject],params[:message])
    sleep(2)
    redirect_to root_path
  end
  
  def blog
    @entries = [{title: 'Helvetica fashion', img: 'http://dummyimage.com/150x150/bbbbbb/fff', body: 'Helvetica fashion axe drinking vinegar, master cleanse yr XOXO selfies tote bag mixtape cliche flannel. Trust fund salvia Etsy, vinyl pop-up plaid crucifix organic meh wolf tofu fap. Hella chia Carles, skateboard put a bird on it tilde quinoa banh mi cred ethical typewriter mlkshk narwhal. Semiotics pour-over typewriter Pinterest craft beer four loko Cosby sweater. Bushwick leggings iPhone Kickstarter quinoa. Cliche Kickstarter polaroid put a bird on it. Bespoke XOXO Truffaut listicle yr church-key. Echo Park Truffaut roof party, selfies twee mustache stumptown tilde salvia cronut Vice shabby chic. Lumbersexual dreamcatcher viral DIY irony. IPhone food truck leggings lomo, cold-pressed jean shorts lumbersexual McSweeneys. Food truck hoodie iPhone, wolf master cleanse Cosby sweater gluten-free sartorial DIY. Craft beer sriracha deep v Vice, ugh direct trade mumblecore distillery seitan tattooed Tonx pour-over lo-fi paleo. Cardigan +1 viral PBR lumbersexual, before they sold out disrupt lo-fi McSweeneys mlkshk wolf skateboard Thundercats flexitarian. Tattooed tofu cronut meggings narwhal taxidermy.'},
                {title: 'Echo Park Truffaut', img: 'http://dummyimage.com/150x150/dddddd/fff', body: 'Echo Park Truffaut roof party, selfies twee mustache stumptown tilde salvia cronut Vice shabby chic. Lumbersexual dreamcatcher viral DIY irony. IPhone food truck leggings lomo, cold-pressed jean shorts lumbersexual McSweeneys. Food truck hoodie iPhone, wolf master cleanse Cosby sweater gluten-free sartorial DIY. Craft beer sriracha deep v Vice, ugh direct trade mumblecore distillery seitan tattooed Tonx pour-over lo-fi paleo. Cardigan +1 viral PBR lumbersexual, before they sold out disrupt lo-fi McSweeneys mlkshk wolf skateboard Thundercats flexitarian. Tattooed tofu cronut meggings narwhal taxidermy. Viral meh +1 fanny pack, migas occupy mustache tote bag disrupt heirloom. Cronut sartorial four loko Williamsburg pickled, shabby chic kale chips Kickstarter Pinterest. Meh selvage chia deep v distillery 90s crucifix pug, Helvetica seitan Tonx brunch four dollar toast. Dreamcatcher single-origin coffee umami fap hoodie sustainable. Drinking vinegar cray fixie mlkshk dreamcatcher gentrify, messenger bag Marfa ennui. Cardigan pork belly readymade next level hashtag distillery. Chambray four dollar toast narwhal hashtag occupy, aesthetic authentic cornhole cardigan.'},
                {title: 'Occupy mustache tote', img: 'http://dummyimage.com/150x150/cccccc/fff', body: 'Viral meh +1 fanny pack, migas occupy mustache tote bag disrupt heirloom. Cronut sartorial four loko Williamsburg pickled, shabby chic kale chips Kickstarter Pinterest. Meh selvage chia deep v distillery 90s crucifix pug, Helvetica seitan Tonx brunch four dollar toast. Dreamcatcher single-origin coffee umami fap hoodie sustainable. Drinking vinegar cray fixie mlkshk dreamcatcher gentrify, messenger bag Marfa ennui. Cardigan pork belly readymade next level hashtag distillery. Chambray four dollar toast narwhal hashtag occupy, aesthetic authentic cornhole cardigan. Helvetica fashion axe drinking vinegar, master cleanse yr XOXO selfies tote bag mixtape cliche flannel. Trust fund salvia Etsy, vinyl pop-up plaid crucifix organic meh wolf tofu fap. Hella chia Carles, skateboard put a bird on it tilde quinoa banh mi cred ethical typewriter mlkshk narwhal. Semiotics pour-over typewriter Pinterest craft beer four loko Cosby sweater. Bushwick leggings iPhone Kickstarter quinoa. Cliche Kickstarter polaroid put a bird on it. Bespoke XOXO Truffaut listicle yr church-key.'}]
  end
end
