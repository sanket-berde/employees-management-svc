using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace employees_management.Models
{
    public class Employee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EmployeeId { get; set; }
        public string? Name { get; set; }
        public string? DateOfBirth { get; set; }
        public string? Position { get; set; }
        public string? Salary { get; set; }
        public string? HireDate { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
    }
}