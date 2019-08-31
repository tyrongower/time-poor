using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using TimePoor.Api.Models;

namespace TimePoor.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProjectController : ControllerBase
    {
        public TimePoorContext Context { get; }
        private readonly ILogger<ProjectController> _logger;

        public ProjectController(ILogger<ProjectController> logger, TimePoorContext context)
        {
            Context = context;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Project>>> GetProjects()
        {
            try
            {
                return await Context.Projects.ToListAsync();
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    "There was an error processing the request");
            }

        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Project>> GetProject(int id)
        {
            try
            {
                var project = await Context.Projects.FindAsync(id);

                if (project == null)
                    return NotFound(id);

                return project;

            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    "There was an error processing the request");
            }
        }

        [HttpPost]
        public async Task<ActionResult<Project>> PostProject(Project project)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                project.Id = 0;
                Context.Projects.Add(project);
                await Context.SaveChangesAsync();

                return CreatedAtAction("GetProject", new {id = project.Id},project);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    "There was an error processing the request");
            }

        }
    }
}
