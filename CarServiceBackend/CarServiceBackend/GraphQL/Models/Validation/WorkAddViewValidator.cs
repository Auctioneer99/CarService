using CarServiceBackend.GraphQL.Models.Work;
using FluentValidation;

namespace CarServiceBackend.GraphQL.Models.Validation
{
    public class WorkAddViewValidator : AbstractValidator<WorkAddView>
    {
        public WorkAddViewValidator()
        {
            RuleFor(w => w.Price).GreaterThan(0);
            RuleFor(w => w.Mileage).GreaterThanOrEqualTo(0);
            RuleFor(w => w.PerformDate).GreaterThan(DateTime.Now - TimeSpan.FromDays(7));
            RuleFor(w => w.ReturnDate).LessThan(DateTime.Now).GreaterThan(w => w.PerformDate);
        }
    }
}
