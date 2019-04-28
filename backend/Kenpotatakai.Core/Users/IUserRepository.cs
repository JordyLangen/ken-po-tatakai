using System.Threading.Tasks;
using Kenpotatakai.Core.Cosmos;

namespace Kenpotatakai.Core.Users
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> GetBy(string platformId);
        Task<User> GetBy(string providerId, string providerName);
    }
}
