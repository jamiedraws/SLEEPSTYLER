using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SJOXTREAM.Models
{
    public class FAQ
    {
        public int DisplayRank { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }

        public FAQ ()
        {
            DisplayRank = 0;
            Question = string.Empty;
            Answer = string.Empty;
        }
    }
}