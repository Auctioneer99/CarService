using CarServiceBackend.GraphQL.Models.Work;
using FluentValidation;

namespace CarServiceBackend.GraphQL.Models.Validation
{
    public class WorkUpdateViewValidator : AbstractValidator<WorkUpdateView>
    {
        public WorkUpdateViewValidator()
        {
            RuleFor(w => w.Price).GreaterThan(0);
            RuleFor(w => w.Mileage).GreaterThanOrEqualTo(0);
            RuleFor(w => w.ReturnDate).LessThan(DateTime.Now);
        }
    }
}
