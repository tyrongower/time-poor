using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using TimePoor.Api;
using TimePoor.Api.Models;

namespace TimePoor.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TimeSheetEntriesController : ControllerBase
    {
        private readonly ILogger<TimeSheetEntriesController> _logger;
        private List<TimeSheetEntry> _timeSheetEntries = new List<TimeSheetEntry>();

        public TimeSheetEntriesController(ILogger<TimeSheetEntriesController> logger)
        {
            _logger = logger;
            _timeSheetEntries.Add(new TimeSheetEntry
            {
                Id = 1,
                Project = new Project
                {
                    Id = 1,
                    Summary = "My Test PRoject",
                    Name = "Hel Me"
                },
                Description = "Doing dev work",
                Hours = 23
            });
        }

        // GET: api/TimeSheetEntries
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TimeSheetEntry>>> GetTimeSheetEntry()
        {
            return _timeSheetEntries;
        }

        // GET: api/TimeSheetEntries/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TimeSheetEntry>> GetTimeSheetEntry(int id)
        {
            var entry = _timeSheetEntries.Find(a => a.Id == id);

            if (entry == null)
                return BadRequest();

            return entry;
        }

        // PUT: api/TimeSheetEntries/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTimeSheetEntry(int id, TimeSheetEntry timeSheetEntry)
        {
            return NoContent();
        }

        // POST: api/TimeSheetEntries
        [HttpPost]
        public async Task<ActionResult<TimeSheetEntry>> PostTimeSheetEntry(TimeSheetEntry timeSheetEntry)
        {
            _logger.LogDebug(_timeSheetEntries.Count.ToString());

            timeSheetEntry.Id = _timeSheetEntries.Max(a => a.Id) + 1;
          _timeSheetEntries.Add(timeSheetEntry); 
          _logger.LogDebug(_timeSheetEntries.Count.ToString());

          Console.WriteLine(_timeSheetEntries.Count.ToString());


            return timeSheetEntry;

        }

        // DELETE: api/TimeSheetEntries/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<TimeSheetEntry>> DeleteTimeSheetEntry(int id)
        {
            var entry = _timeSheetEntries.Find(a => a.Id == id);

            if (entry == null)
                return NotFound();

            _timeSheetEntries.Remove(entry);
            return entry;
        }

        private bool TimeSheetEntryExists(int id)
        {
            return _timeSheetEntries.Any(a => a.Id == id);
        }
    }
}
