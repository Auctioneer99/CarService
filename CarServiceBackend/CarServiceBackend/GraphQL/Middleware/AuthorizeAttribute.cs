using CarServiceBackend.Auth;
using HotChocolate.Types.Descriptors;
using System.Reflection;

namespace CarServiceBackend.GraphQL.Middleware
{
    public class MyAuthorizeAttribute : ObjectFieldDescriptorAttribute
    {
        private readonly ERole _role;

        public MyAuthorizeAttribute(ERole role = ERole.All)
        {
            _role = role;
        }

        public override void OnConfigure(
            IDescriptorContext context,
            IObjectFieldDescriptor descriptor,
            MemberInfo member
            )
        {
            descriptor.Authorize(_role.GetStrings());
        }
    }
}
