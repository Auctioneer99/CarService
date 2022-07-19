using CarServiceBackend.Auth;
using CarServiceBackend.GraphQL.Middleware;
using CarServiceBackend.GraphQL.Models;
using CarServiceBackend.GraphQL.Queries.Executor;

namespace CarServiceBackend.GraphQL.Queries
{
    public class Mutation
    {
        [MyAuthorize(ERole.Executor)]
        [Error(typeof(InvalidEntityException))]
        public ExecutorMutation ExecutorMutation { get; set; } = new ExecutorMutation();
    }
}
