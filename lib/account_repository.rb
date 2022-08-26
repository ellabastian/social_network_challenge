require 'account'

class AccountRepository

    def all
        sql = 'SELECT * FROM accounts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        accounts = []

        result_set.each do |item|
            account = Account.new

            account.id = item['id']
            account.email_address = item['email_address']
            account.username = item['username']

            accounts << account
        end

        return accounts   
    end


    def find(id)
        sql = 'SELECT * FROM accounts WHERE id = $1;'
        sql_params = [id]

        result_set = DatabaseConnection.exec_params(sql, sql_params)
        item = result_set[0]

        account = Account.new

        account.id = item['id']
        account.email_address = item['email_address']
        account.username = item['username']

        return account
    end

    def create(account)
        sql = 'INSERT INTO accounts(email_address, username) VALUES($1, $2);'
        sql_params = [account.email_address, account.username]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM accounts WHERE id = $1;'
        sql_params = [id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil

    end
end