import Foundation


enum KnockKnockState: String
{
    case KnockKnock = "Knock, Knock",
         WhosThere = "Who's There?",
         Laugh = "HaHa"
    
    func next() -> KnockKnockState
    {
        switch(self)
        {
            case .KnockKnock:
                return .WhosThere
            case .WhosThere:
                return .Laugh
            case .Laugh:
                return .KnockKnock
        }
    }
}
