using System;
using System.ComponentModel.DataAnnotations;

namespace TimePoor.Api
{
    public class Project
    {
        [Key]
       public int Id { get; set; }

        public string Name{ get; set; }

        public string Summary { get; set; }
    }

    public class TimeSheetEntry
    {
        [Key]
        public int Id { get; set; }

        public double Hours { get; set; }

        public string  Description { get; set; }

        [Required]
        public Project Project { get; set; }
    }
}
