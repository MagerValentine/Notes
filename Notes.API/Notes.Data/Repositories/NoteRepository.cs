using Dapper;
using Notes.Data.Models;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Notes.Data.Repositories
{
    class NoteRepository : IRepository<Note>
    {
        private string _connectionString;
        public NoteRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public async Task Create(Note item)
        {
            var query = "INSERT INTO Notes (Id, Title, Text, CreateDate, UserId) VALUES (@Id, @Title, @Text, @CreateDate, @UserId)";
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.ExecuteAsync(query, item);
        }

        public async Task Delete(Guid id)
        {
            var query = "DELETE FROM Notes WHERE Id = @Id";
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.ExecuteAsync(query, new { id });
        }

        public async Task<Note> Get(Guid id)
        {
            var query = "SELECT * FROM Notes WHERE Id = @Id";
            using var connection = new NpgsqlConnection(_connectionString);
            return await connection.QueryFirstAsync<Note>(query, new { id });
        }

        public async Task<IEnumerable<Note>> Get()
        {
            var query = "SELECT * FROM Notes";
            using var connection = new NpgsqlConnection(_connectionString);
            return await connection.QueryAsync<Note>(query);
        }

        public async Task Update(Note item)
        {
            var query = "UPDATE Notes SET Title=@Title, Text=@Text";
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.ExecuteAsync(query, item);
        }
    }
}
