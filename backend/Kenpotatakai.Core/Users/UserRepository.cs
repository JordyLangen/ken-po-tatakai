using System.Linq;
using System.Threading.Tasks;
using Kenpotatakai.Core.Cosmos;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;

namespace Kenpotatakai.Core.Users
{
    public class UserRepository : Repository<User>, IUserRepository
    {
        public UserRepository(IDocumentClient documentClient)
            : base(documentClient, "Users")
        {
        }

        public Task<User> GetBy(string platformId)
        {
            var existingUser = DocumentClient.CreateDocumentQuery<User>(CollectionUri, new FeedOptions
                {
                    MaxItemCount = -1,
                    EnableCrossPartitionQuery = true
                })
                .Where(user => user.PlatformId == platformId)
                .ToList()
                .SingleOrDefault();

            return Task.FromResult(existingUser);
        }

        public Task<User> GetBy(string providerId, string providerName)
        {
            var existingUser = DocumentClient.CreateDocumentQuery<User>(CollectionUri, new FeedOptions
                {
                    EnableCrossPartitionQuery = true
                })
                .Where(user => user.ProviderId == providerId && user.ProviderName == providerName)
                .ToList()
                .SingleOrDefault();

            return Task.FromResult(existingUser);
        }
    }
}