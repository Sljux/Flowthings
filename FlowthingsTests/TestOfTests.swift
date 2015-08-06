import Quick
import Nimble
import Flowthings

class TestTests: QuickSpec {
    
    var api : API = Flowthings(accountID: "ceco", tokenID: "6GMlrMISkC95NsTvadZKetBrgo4G0TKW").api
    
    override func spec() {
        
        
        beforeEach {

            print("NEW TEST")
        }
        
        describe(".TestTest") {
            // fetchMinions Tests go here

            let flowID = "f55b991ab68056d7454984a87"
            let dropID = "d55b991ab68056d7454984a8d"

            print("CECO")
            self.api.drop.read(flowID: flowID, dropID: dropID,
                success:{
                    body in
                
                expect(1 + 1).to(equal("Squee!"))
            },
            failure:{
                error in

                XCTFail("DropAPIRead failed")
            })
        }
    }
    
}