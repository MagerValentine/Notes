using System;

namespace Notes.Data.Models
{
    public class Note
    {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string Text { get; set; }
        public DateTime CreateDate { get; set; }
        public Guid UserId { get; set; }
    }
}
