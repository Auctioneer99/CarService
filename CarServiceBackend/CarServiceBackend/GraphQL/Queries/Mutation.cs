using CarServiceBackend.Auth;
using CarServiceBackend.GraphQL.Middleware;
using CarServiceBackend.GraphQL.Queries.Executor;

namespace CarServiceBackend.GraphQL.Queries
{
    public class Mutation
    {
        [MyAuthorize(ERole.Executor)]
        public ExecutorMutation ExecutorMutation { get; set; } = new ExecutorMutation();
    }
}
