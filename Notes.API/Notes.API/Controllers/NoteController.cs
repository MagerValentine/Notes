using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Notes.API.Models;
using Notes.Data;
using Notes.Data.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Notes.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NoteController : ControllerBase
    {
        private DataManager _dataManager { get; set; }
        public NoteController(DataManager dataManager)
        {
            _dataManager = dataManager;
        }
        // GET: api/<NoteControoler>
        [HttpGet]
        public async Task<IEnumerable<NoteViewModel>> Get()
        {
            var notes = await _dataManager.Notes.Get();
            return notes.Select(note => new NoteViewModel(note));

        }

        // GET api/<NoteControoler>/5
        [HttpGet("{id}")]
        public async Task<NoteViewModel> Get(Guid id)
        {
            var note = await _dataManager.Notes.Get(id);
            return new NoteViewModel(note);
        }

        // POST api/<NoteControoler>
        [HttpPost]
        public async Task Post([FromBody] NoteViewModel value)
        {
            var note = new Note { Id = Guid.NewGuid(), CreateDate = DateTime.UtcNow, Text = value.Text, Title = value.Title, UserId = value.UserId };
            await _dataManager.Notes.Create(note);
        }

        // PUT api/<NoteControoler>/5
        [HttpPut("{id}")]
        public async Task Put(Guid id, [FromBody] NoteViewModel value)
        {
            var note = new Note { Id = value.Id, CreateDate = value.CreateDate, Text = value.Text, Title = value.Title, UserId = value.UserId };
            await _dataManager.Notes.Update(note);
        }

        // DELETE api/<NoteControoler>/5
        [HttpDelete("{id}")]
        public async Task Delete(Guid id)
        {
            await _dataManager.Notes.Delete(id);
        }
    }
}
