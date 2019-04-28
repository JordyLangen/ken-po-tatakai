using Kenpotatakai.Core.Cosmos;
using Microsoft.Azure.Documents;

namespace Kenpotatakai.Core.Users
{
    public class UserRepository : Repository<User>, IUserRepository
    {
        public UserRepository(IDocumentClient documentClient)
            : base(documentClient, "Users")
        {
        }
    }
}