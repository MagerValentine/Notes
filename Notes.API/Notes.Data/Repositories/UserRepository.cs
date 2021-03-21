using Dapper;
using Notes.Data.Models;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Notes.Data.Repositories
{
    class UserRepository : IRepository<User>
    {
        private string _connectionString;
        public UserRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public async Task Create(User item)
        {
            var query = "INSERT INTO Users (Id, Email, UserName) VALUES (@Id, @Email, @UserName)";
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.ExecuteAsync(query, item);
        }

        public async Task Delete(Guid id)
        {
            var query = "DELETE FROM Users WHERE Id=@Id";
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.ExecuteAsync(query, new { id });
        }

        public async Task<User> Get(Guid id)
        {
            var query = "SELECT * FROM Users WHERE Id=@Id";
            using var connection = new NpgsqlConnection(_connectionString);
            return await connection.QueryFirstAsync<User>(query);
        }

        public async Task<IEnumerable<User>> Get()
        {
            var query = "SELECT * FROM Users";
            using var connection = new NpgsqlConnection(_connectionString);
            return await connection.QueryAsync<User>(query);
        }

        public async Task Update(User item)
        {
            var query = "UPDATE Users SET Email=@Email, UserName=@UserName WHERE Id=@Id";
            using var connection = new NpgsqlConnection(_connectionString);
            var creationResult = await connection.ExecuteAsync(query, item);
        }
    }
}
