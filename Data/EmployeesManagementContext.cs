using Microsoft.EntityFrameworkCore;
using employees_management.Models;

namespace employees_management.Data
{
    public class EmployeesManagementDbContext : DbContext
    {
        public EmployeesManagementDbContext(DbContextOptions<EmployeesManagementDbContext> options)
            : base(options) { }

        public DbSet<Employee> Employees { get; set; }
        
    }
}
