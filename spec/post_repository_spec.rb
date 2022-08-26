require "post_repository"

def reset_posts_table
    seed_sql = File.read('./spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
    puts "executed trace"
  end



RSpec.describe 'PostRepository class' do
    describe PostRepository do
        before(:each) do 
          reset_posts_table
        end
    
    it 'returns all posts' do 
        repo = PostRepository.new

        posts = repo.all

        expect(posts.length).to eq 2

        expect(posts[0].title).to eq 'A day in the life of..'
        expect(posts[0].content).to eq 'This is a diary of my day'
        expect(posts[0].views.to_i).to eq 600
        expect(posts[0].account_id.to_i).to eq 1

        expect(posts[1].title).to eq 'Favourite foods'
        expect(posts[1].content).to eq 'My favourite food is chocolate'
        expect(posts[1].views.to_i).to eq 1000
        expect(posts[1].account_id.to_i).to eq 2
    end

    it 'returns a single post' do
        repo = PostRepository.new

        post = repo.find(1)

        expect(post.id.to_i).to eq 1
        expect(post.title).to eq 'A day in the life of..'
        expect(post.content).to eq 'This is a diary of my day'
        expect(post.views.to_i).to eq 600
        expect(post.account_id.to_i).to eq 1
    end

    it 'creates a new post' do
        repo = PostRepository.new

        post = Post.new
        post.title = 'How to ride a bike'
        post.content = 'An explanation of how to ride a bike'
        post.views = 50
        post.account_id = 1

        repo.create(post)

        post = repo.all

        last_post = post.last
        expect(last_post.title).to eq 'How to ride a bike'
        expect(last_post.content).to eq 'An explanation of how to ride a bike'
        expect(last_post.views.to_i).to eq 50
        expect(last_post.account_id.to_i).to eq 1
    end

    it 'deletes a post based on id' do
        repo = PostRepository.new

        repo.delete(1)

        posts = repo.all
        expect(posts.length).to eq 1
        expect(posts.first.id.to_i).to eq 2
    end

    it 'updates a post' do
        repo = PostRepository.new

        post = repo.find(1)
        p post

        post.title = 'Favourite foods and drinks'
        p post.title
        post.content = 'My favourite food is pizza'
        p post.content
        post.views = 100
        p post.views

        repo.update(post)
        p repo

        updated_post = repo.find(1)
        p updated_post

        expect(updated_post.title).to eq 'Favourite foods and drinks'
        expect(updated_post.content).to eq 'My favourite food is pizza'
        expect(updated_post.views.to_i).to eq 100
        expect(updated_post.account_id.to_i).to eq 1
    end
end
end   

