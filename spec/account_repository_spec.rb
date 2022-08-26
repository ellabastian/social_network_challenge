require 'account_repository'

def reset_accounts_table
    seed_sql = File.read('./spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

RSpec.describe 'AccountRepository' do
    describe AccountRepository do
        before(:each) do 
          reset_accounts_table
        end
    
    it 'returns a list of account objects' do
        repo = AccountRepository.new

        accounts = repo.all

        expect(accounts.length).to eq 2

        expect(accounts[0].id.to_i).to eq 1
        expect(accounts[0].email_address).to eq 'davidjackson@google.com'
        expect(accounts[0].username).to eq 'davidjackson'

        expect(accounts[1].id.to_i).to eq 2
        expect(accounts[1].email_address).to eq 'emmawatson@google.com'
        expect(accounts[1].username).to eq 'emmawatson1'
    end

    it 'returns a single object based on id' do
        repo = AccountRepository.new

        account = repo.find(1)

        expect(account.id.to_i).to eq 1
        expect(account.email_address).to eq'davidjackson@google.com'
        expect(account.username).to eq 'davidjackson'
    end

    it 'creates a new account' do
        repo = AccountRepository.new

        account = Account.new
        account.email_address = 'ella@google.com'
        account.username = 'ellab'

        repo.create(account)

        accounts = repo.all
        last_account = accounts.last

        expect(last_account.email_address).to eq 'ella@google.com'
        expect(last_account.username).to eq 'ellab'
    end

    it 'deletes an account based on id' do
        repo = AccountRepository.new

        repo.delete(1)
        
        accounts = repo.all

        expect(accounts.length).to eq 1
        expect(accounts.first.id.to_i).to eq 2
    end 
end
end 