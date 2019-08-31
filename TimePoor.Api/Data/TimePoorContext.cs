using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using TimePoor.Api;

namespace TimePoor.Api.Models
{
    public class TimePoorContext : DbContext
    {
        public TimePoorContext (DbContextOptions<TimePoorContext> options)
            : base(options)
        {
        }

        public DbSet<TimePoor.Api.TimeSheetEntry> TimeSheetEntries { get; set; }
        public DbSet<TimePoor.Api.Project> Projects { get; set; }
    }
}
