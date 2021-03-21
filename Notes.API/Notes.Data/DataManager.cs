using Notes.Data.Models;
using Notes.Data.Repositories;

namespace Notes.Data
{
    public class DataManager
    {
        public IRepository<User> Users { get; set; }
        public IRepository<Note> Notes { get; set; }
        public DataManager(string connectionString)
        {
            Users = new UserRepository(connectionString);
            Notes = new NoteRepository(connectionString);
        }
    }
}
