using Notes.Data.Models;
using System;

namespace Notes.API.Models
{
    public class NoteViewModel
    {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string Text { get; set; }
        public Guid UserId { get; set; }
        public DateTime CreateDate { get; set; }
        public NoteViewModel()
        {

        }
        public NoteViewModel(Note note)
        {
            Id = note.Id;
            Title = note.Title;
            Text = note.Text;
            CreateDate = note.CreateDate;
            UserId = note.UserId;
        }
    }
}
