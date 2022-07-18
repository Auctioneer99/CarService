using CarServiceBackend.GraphQL.Models.Transport;
using FluentValidation;

namespace CarServiceBackend.GraphQL.Models.Validation
{
    public class TransportAddViewValidator : AbstractValidator<TransportAddView>
    {
        public TransportAddViewValidator()
        {
            RuleFor(t => t.Number).Matches(@"^[АВЕКМНОРСТУХ]\d{3}(?<!000)[АВЕКМНОРСТУХ]{2}(?!00)[1-9]?\d{2}$");
            RuleFor(t => t.Model).NotEmpty();
        }
    }
}
